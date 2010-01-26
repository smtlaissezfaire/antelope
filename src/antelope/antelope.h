enum types {
  RULE = 1,
  LITERAL,
  ALTERNATION,
  GROUPED_EXPRESSION,
  OPTIONAL_EXPRESSION,
  OPTIONAL_REPETITION,
  REPETITION
};

struct literal {
  unsigned int   identifier;
  enum types     type;
  unsigned int * references;
  char *         text;
  int            (*function)(int);
};
