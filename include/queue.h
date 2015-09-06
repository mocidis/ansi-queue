#ifndef __ANSI_CONCURRENT_QUEUE_H__
#define __ANSI_CONCURRENT_QUEUE_H__
#include <pthread.h>
#include <stdio.h>      /* printf, scanf, NULL */
#include <stdlib.h>     /* calloc, exit, free */

#define QUEUE_CAP 100

#define QE_EXIT 18834

typedef struct __queue queue_t;
struct __queue
{
    void **buffer;
    int capacity;
    int size;
    int in;
    int out;
    pthread_mutex_t mutex;
    pthread_cond_t cond_full;
    pthread_cond_t cond_empty;
};
#define QUEUE_INITIALIZER(buffer) { (buffer), sizeof(buffer) / sizeof((buffer)[0]), 0, 0, 0, PTHREAD_MUTEX_INITIALIZER, PTHREAD_COND_INITIALIZER, PTHREAD_COND_INITIALIZER}
void queue_enqueue(queue_t *queue, void *value);
void *queue_dequeue(queue_t *queue);
int queue_size(queue_t *queue);
void queue_init(queue_t *queue, int cap, int data_size);
#endif
