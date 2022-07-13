

CC=gcc
CFLAGS=-fprofile-arcs -fprofile-abs-path -ftest-coverage

SRC_DIR=src
OBJ_DIR=obj

SRCS=$(wildcard $(SRC_DIR)/*.c)
OBJS=$(patsubst $(SRC_DIR)/%.c, $(OBJ_DIR)/%.o, $(SRCS))

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c
	$(CC) $(CFLAGS) -c -o $@ $^

app: $(OBJS)
	$(CC) $(CFLAGS) $^ -o $@

main.c.gcov: app
	./app
	gcov -o obj src/*.c

coverage: main.c.gcov	

.PHONY: clean
clean:
	rm $(OBJ_DIR)/* *.gcda *.gcno *.gcov
