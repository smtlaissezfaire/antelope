#ifndef _ANTELOPE_H_
#define _ANTELOPE_H_

#include <string.h>
#define  PARSE_FAILURE -1

typedef unsigned int     uint;
typedef char *           string;
typedef struct node      node;
typedef struct entry     entry;
typedef struct node_set* node_set;

enum types {
  RULE = 1,
  LITERAL,
  ALTERNATION,
  GROUPED_EXPRESSION,
  OPTIONAL_EXPRESSION,
  OPTIONAL_REPETITION,
  REPETITION
};

struct node {
  uint       identifier;
  enum types type;
  uint *     references;
  string     text;
  int        (*parse)(node *, int, string);
};

struct entry {
  int key;
  void *value;
  entry *next;
};

struct node_set {
  node    *node;
  node_set next;
};

void add_node(node_set, node *);
node *find_node(node_set, int);

node mk_literal    (uint, string);
node mk_rule       (uint, uint *);
node mk_alternation(uint, uint *);
int parse_literal    (node *, int, string);
int parse_rule       (node *, int, string);
int parse_alternation(node *, int, string);

#endif