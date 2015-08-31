.PHONY: all clean
APP := test-queue

C_DIR := ../common
C_SRCS := my-pjlib-utils.c

OPOOL_DIR := .
OPOOL_SRCS := queue.c

MAIN_DIR := .
MAIN_SRCS := test-queue.c

LIBS := -std=c99 $(shell pkg-config libpjproject --libs) -Werror

CFLAGS := $(shell pkg-config libpjproject --cflags) -I$(C_DIR)/include -I$(OPOOL_DIR)/include

all: $(APP)

$(APP): $(C_SRCS:.c=.o) $(OPOOL_SRCS:.c=.o) $(MAIN_SRCS:.c=.o)
	gcc -o $@ $^ $(LIBS)

$(C_SRCS:.c=.o): %.o: $(C_DIR)/src/%.c
	gcc -o $@ -c $< $(CFLAGS)

$(MAIN_SRCS:.c=.o): %.o: $(MAIN_DIR)/test/%.c
	gcc -o $@ -c $< $(CFLAGS)

$(OPOOL_SRCS:.c=.o): %.o: $(OPOOL_DIR)/src/%.c
	gcc -o $@ -c $< $(CFLAGS)

clean:
	rm -fr *.o $(APP)
