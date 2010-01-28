#include <string.h>

#define PARSE_FAILURE -1

typedef unsigned int uint;
typedef char *       string;
typedef struct node  node;

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

node mk_literal   (uint, string);
node mk_rule      (uint, uint *);
int parse_literal (node *, int, string);
int parse_rule    (node *, int, string);