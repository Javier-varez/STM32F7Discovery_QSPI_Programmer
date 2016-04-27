
#include "Circ_Buff.h"

circularBuffer *circularBuffer_CreateBuffer(uint32_t size) {
  circularBuffer *buff = malloc(sizeof(circularBuffer));
  if (buff) {
    buff->buffer = calloc(size, sizeof(sample_t));
    if (buff->buffer) {
      buff->offset = size-1;
      buff->size = size;
    } else {
      free(buff);
    }
  }
  return buff;
}

sample_t circularBuffer_Read(circularBuffer *buff, uint32_t position) {
  uint32_t realPos = buff->offset + position;
  if (realPos >= buff->size) realPos = realPos - buff->size;

  return buff->buffer[realPos];
}

inline void circularBuffer_Write(circularBuffer *buff, sample_t data) {
  buff->offset--;
  if (buff->offset >= buff->size) buff->offset = buff->size-1;

  buff->buffer[buff->offset] = data;
}

void circularBuffer_WriteMultiple(circularBuffer *buff, sample_t *data, uint32_t length) {
  int i;
  for (i = 0; i < length; i++) {
    circularBuffer_Write(buff, data[i]);
  }
}

void circularBuffer_DestroyBuffer(circularBuffer *buff) {
  free(buff->buffer);
  free(buff);
}
