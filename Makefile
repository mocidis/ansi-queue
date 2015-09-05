.PHONY: all clean
APP := test-queue


QUEUE_DIR := .
QUEUE_SRCS := queue.c

MAIN_DIR := .
MAIN_SRCS := test-queue.c

LIBS := -std=c99  -Werror

CFLAGS := -I$(C_DIR)/include -I$(QUEUE_DIR)/include

all: $(APP)

$(APP): $(QUEUE_SRCS:.c=.o) $(MAIN_SRCS:.c=.o)
	gcc -o $@ $^ $(LIBS)

$(MAIN_SRCS:.c=.o): %.o: $(MAIN_DIR)/test/%.c
	gcc -o $@ -c $< $(CFLAGS)

$(QUEUE_SRCS:.c=.o): %.o: $(QUEUE_DIR)/src/%.c
	gcc -o $@ -c $< $(CFLAGS)

clean:
	rm -fr *.o $(APP)
