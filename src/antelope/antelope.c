#include "antelope.h"

node mk_node(uint identifier, enum types type, int (*parse_func)(int, string)) {
  node n;
  n.identifier = identifier;
  n.type       = type;
  n.parse      = parse_func;
  return n;
}

node mk_literal(uint identifier, string str) {
  node n = mk_node(identifier, LITERAL, parse_literal);
  n.text = str;
  return n;
}

node mk_rule(uint identifier, uint * references) {
  node n = mk_node(identifier, RULE, parse_rule);
  n.references = references;
  return n;
}

int parse_literal(int start, string str) {}
int parse_rule(int start, string str) {}
