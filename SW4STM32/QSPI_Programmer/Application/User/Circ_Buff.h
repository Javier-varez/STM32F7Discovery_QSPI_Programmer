
#ifndef CIRCULAR_BUFFER_H
#define CIRCULAR_BUFFER_H

#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>

typedef uint8_t sample_t;

typedef struct {
  sample_t *buffer;
  uint32_t offset;
  uint32_t size;
} circularBuffer;


circularBuffer *circularBuffer_CreateBuffer(uint32_t size);
sample_t circularBuffer_Read(circularBuffer *buff, uint32_t position);
inline void circularBuffer_Write(circularBuffer *buff, sample_t data);
void circularBuffer_WriteMultiple(circularBuffer *buff, sample_t *data, uint32_t length);
void circularBuffer_DestroyBuffer(circularBuffer *buff);


#endif
