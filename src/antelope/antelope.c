#include "antelope.h"

node mk_node(int identifier, enum types type) {
  node n;
  n.identifier = identifier;
  n.type       = type;
  return n;
}

node mk_literal(int identifier, char * str) {
  node n = mk_node(identifier, LITERAL);
  n.text = str;
  return n;
}

node mk_rule(int identifier, unsigned int * references) {
  node n = mk_node(identifier, RULE);
  n.references = references;
  return n;
}

