/**
  ******************************************************************************
  * File Name          : main.c
  * Description        : Main program body
  ******************************************************************************
  *
  * COPYRIGHT(c) 2016 STMicroelectronics
  *
  * Redistribution and use in source and binary forms, with or without modification,
  * are permitted provided that the following conditions are met:
  *   1. Redistributions of source code must retain the above copyright notice,
  *      this list of conditions and the following disclaimer.
  *   2. Redistributions in binary form must reproduce the above copyright notice,
  *      this list of conditions and the following disclaimer in the documentation
  *      and/or other materials provided with the distribution.
  *   3. Neither the name of STMicroelectronics nor the names of its contributors
  *      may be used to endorse or promote products derived from this software
  *      without specific prior written permission.
  *
  * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
  * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
  * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
  * DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
  * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
  * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
  * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
  * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
  * OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
  * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  *
  ******************************************************************************
  */
/* Includes ------------------------------------------------------------------*/
#include "stm32f7xx_hal.h"
#include "usart.h"
#include "gpio.h"

/* USER CODE BEGIN Includes */
#include <string.h>
#include "stm32746g_discovery_qspi.h"
#include "Circ_Buff.h"
/* USER CODE END Includes */

/* Private variables ---------------------------------------------------------*/

/* USER CODE BEGIN PV */
/* Private variables ---------------------------------------------------------*/

// Application should provide the user with this key to begin QSPI Operation
// 16 bit key
#define MASTER_KEY 0x3030303030303031
#define UART_TIMEOUT 10000
#define USART_HANDLE huart1

// Stores characters received through the UART Interface to later check password.
circularBuffer *passBuffer;

uint8_t singleByteBuffer;

/* USER CODE END PV */

/* Private function prototypes -----------------------------------------------*/
void SystemClock_Config(void);

/* USER CODE BEGIN PFP */
/* Private function prototypes -----------------------------------------------*/
int checkKey();
void QSPI_MemoryDump();
void QSPI_WriteMem();
/* USER CODE END PFP */

/* USER CODE BEGIN 0 */

/* USER CODE END 0 */

int main(void)
{

  /* USER CODE BEGIN 1 */

  /* USER CODE END 1 */

  /* MCU Configuration----------------------------------------------------------*/

  /* Reset of all peripherals, Initializes the Flash interface and the Systick. */
  HAL_Init();

  /* Configure the system clock */
  SystemClock_Config();

  /* Initialize all configured peripherals */
  MX_GPIO_Init();
  MX_USART1_UART_Init();

  /* USER CODE BEGIN 2 */
  BSP_QSPI_Init();

  passBuffer = circularBuffer_CreateBuffer(8);

  HAL_UART_Receive_IT(&USART_HANDLE, &singleByteBuffer, 1);
  /* USER CODE END 2 */

  /* Infinite loop */
  /* USER CODE BEGIN WHILE */
  while (1)
  {
  /* USER CODE END WHILE */

  /* USER CODE BEGIN 3 */

  }
  /* USER CODE END 3 */

}

/** System Clock Configuration
*/
void SystemClock_Config(void)
{

  RCC_OscInitTypeDef RCC_OscInitStruct;
  RCC_ClkInitTypeDef RCC_ClkInitStruct;
  RCC_PeriphCLKInitTypeDef PeriphClkInitStruct;

  __PWR_CLK_ENABLE();

  __HAL_PWR_VOLTAGESCALING_CONFIG(PWR_REGULATOR_VOLTAGE_SCALE2);

  RCC_OscInitStruct.OscillatorType = RCC_OSCILLATORTYPE_HSI;
  RCC_OscInitStruct.HSIState = RCC_HSI_ON;
  RCC_OscInitStruct.HSICalibrationValue = 16;
  RCC_OscInitStruct.PLL.PLLState = RCC_PLL_ON;
  RCC_OscInitStruct.PLL.PLLSource = RCC_PLLSOURCE_HSI;
  RCC_OscInitStruct.PLL.PLLM = 10;
  RCC_OscInitStruct.PLL.PLLN = 210;
  RCC_OscInitStruct.PLL.PLLP = RCC_PLLP_DIV2;
  RCC_OscInitStruct.PLL.PLLQ = 2;
  HAL_RCC_OscConfig(&RCC_OscInitStruct);

  RCC_ClkInitStruct.ClockType = RCC_CLOCKTYPE_HCLK|RCC_CLOCKTYPE_SYSCLK
                              |RCC_CLOCKTYPE_PCLK1|RCC_CLOCKTYPE_PCLK2;
  RCC_ClkInitStruct.SYSCLKSource = RCC_SYSCLKSOURCE_PLLCLK;
  RCC_ClkInitStruct.AHBCLKDivider = RCC_SYSCLK_DIV1;
  RCC_ClkInitStruct.APB1CLKDivider = RCC_HCLK_DIV4;
  RCC_ClkInitStruct.APB2CLKDivider = RCC_HCLK_DIV2;
  HAL_RCC_ClockConfig(&RCC_ClkInitStruct, FLASH_LATENCY_5);

  PeriphClkInitStruct.PeriphClockSelection = RCC_PERIPHCLK_USART1;
  PeriphClkInitStruct.Usart1ClockSelection = RCC_USART1CLKSOURCE_PCLK2;
  HAL_RCCEx_PeriphCLKConfig(&PeriphClkInitStruct);

  HAL_SYSTICK_Config(HAL_RCC_GetHCLKFreq()/1000);

  HAL_SYSTICK_CLKSourceConfig(SYSTICK_CLKSOURCE_HCLK);

  /* SysTick_IRQn interrupt configuration */
  HAL_NVIC_SetPriority(SysTick_IRQn, 0, 0);
}

/* USER CODE BEGIN 4 */
void HAL_UART_RxCpltCallback(UART_HandleTypeDef *huart){
	static uint8_t pModeActive = 0;

	if (pModeActive) {
		switch (singleByteBuffer) {
		case 0x30:
			QSPI_MemoryDump();
			break;
		case 0x31:
			QSPI_WriteMem();
			break;
		default:
			break;
		}
		pModeActive = 0;
	} else {
		circularBuffer_Write(passBuffer, singleByteBuffer);
		if (checkKey()) {
			pModeActive = 1;
		}
	}
	HAL_UART_Receive_IT(&huart1, &singleByteBuffer, 1);
}

int checkKey() {
	uint64_t masterKey = MASTER_KEY;
	uint8_t *keyPointer = (uint8_t*)&masterKey;

	uint8_t i;
	for (i = 0; i < 8; i++) {
		if (keyPointer[i] != circularBuffer_Read(passBuffer, i)) return 0;
	}

	// If it reaches this point, Key is CORRECT
	return 1;
}

void QSPI_MemoryDump() {
	uint32_t i = 0;

	// Transmit ACK
	uint8_t ACK = 0xAA;
	HAL_UART_Transmit(&USART_HANDLE, &ACK, 1, UART_TIMEOUT);

	// Receive Dump Length and Start Address
	uint32_t length;
	HAL_UART_Receive(&USART_HANDLE, (uint8_t*)&length, 4, UART_TIMEOUT);
	length &= 0x7FFFFF; // Max 8 MB

	uint32_t addr;
	HAL_UART_Receive(&USART_HANDLE, (uint8_t*)&addr, 4, UART_TIMEOUT);
	addr &= 0x7FFFFF; // Max 8 MB

	uint8_t buff;
	for (i = 0; i <= length; i++) {
		BSP_QSPI_Read(&buff, i+addr, 1);
		HAL_UART_Transmit(&USART_HANDLE, &buff, 1, UART_TIMEOUT);
	}
}


void QSPI_WriteMem() {
	uint32_t i = 0;

	// Transmit ACK
	uint8_t ACK = 0xBB;
	HAL_UART_Transmit(&USART_HANDLE, &ACK, 1, UART_TIMEOUT);

	// Receive Dump Length and Start Address
	uint32_t length;
	HAL_UART_Receive(&USART_HANDLE, (uint8_t*)&length, 4, UART_TIMEOUT);
	length &= 0x7FFFFF; // Max 8 MB

	uint32_t addr;
	HAL_UART_Receive(&USART_HANDLE, (uint8_t*)&addr, 4, UART_TIMEOUT);
	addr &= 0x7FFFFF; // Max 8 MB

	// Erase Corresponding Memory Blocks
	for (i = addr; i <= addr+length; i += 0x1000) {
		BSP_QSPI_Erase_Block(i);
	}

	ACK = 0xAA;
	HAL_UART_Transmit(&USART_HANDLE, &ACK, 1, UART_TIMEOUT);

	// Write Data
	uint8_t buff;
	for (i = 0; i <= length; i++) {
		HAL_UART_Receive(&USART_HANDLE, &buff, 1, UART_TIMEOUT);
		if (BSP_QSPI_Write(&buff, i+addr, 1) != QSPI_OK) {
			return;
		}
	}
}


/* USER CODE END 4 */

#ifdef USE_FULL_ASSERT

/**
   * @brief Reports the name of the source file and the source line number
   * where the assert_param error has occurred.
   * @param file: pointer to the source file name
   * @param line: assert_param error line source number
   * @retval None
   */
void assert_failed(uint8_t* file, uint32_t line)
{
  /* USER CODE BEGIN 6 */
  /* User can add his own implementation to report the file name and line number,
    ex: printf("Wrong parameters value: file %s on line %d\r\n", file, line) */
  /* USER CODE END 6 */

}

#endif

/**
  * @}
  */ 

/**
  * @}
*/ 

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
