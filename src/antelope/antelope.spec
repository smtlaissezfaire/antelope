#include "cspec.h"
#include "antelope.h"
#include "limits.h"
#include "string.h"

static int nbefore_each;

describe "basic specs"
  before_each
    ++nbefore_each;
  end

  it "should be called before each spec"
    nbefore_each should equal 1
  end

  it "should be called before each spec"
    nbefore_each should equal 2
  end
end

struct node node_struct;

int generic_parse_function(node * self, int x, char * str) {
  (void)self;
  (void)(str);
  return x * x;
}

describe "node struct"
  it "should have type as an integer"
    node_struct.type = 1;
    node_struct.type should equal 1

    node_struct.type = 2;
    node_struct.type should equal 2
  end

  it "should have the identifier as an unsigned int"
    node_struct.identifier = UINT_MAX;
    node_struct.identifier should equal UINT_MAX;
  end

  it "should have an optional body of text"
    char *x = "foo";
    node_struct.text = x;
    node_struct.text should equal x
  end

  it "should have a list of references"
    unsigned int *references = malloc(sizeof(int) * 2);
    references[0] = 0;
    references[1] = 1;

    node_struct.references = references;
    node_struct.references should equal references;
  end

  it "should have the parse function"
    node_struct.parse = generic_parse_function;
    int x = (*node_struct.parse)(&node_struct, 4, "");
    x should equal 16
  end
end

describe "types"
  it "should have type 1 as a rule"
    enum types type = RULE;
    type should equal 1
  end

  it "should have a literal as type 2"
    enum types type = LITERAL;
    type should equal 2
  end

  it "should have an alternation as type 3"
    enum types type = ALTERNATION;
    type should equal 3
  end

  it "should have a grouped expression as type 4"
    enum types type = GROUPED_EXPRESSION;
    type should equal 4
  end

  it "should have an optional expression as type 5"
    enum types type = OPTIONAL_EXPRESSION;
    type should equal 5
  end

  it "should have an optional repetition as type 6"
    enum types type = OPTIONAL_REPETITION;
    type should equal 6
  end

  it "should have a repetition as type 7"
    enum types type = REPETITION;
    type should equal 7
  end
end

describe "mk_literal"
  it "should set the id"
    int str = mk_literal(10, "foo").identifier;
    str should equal 10
  end

  it "should use the correct id"
    int str = mk_literal(100, "foo").identifier;
    str should equal 100
  end

  it "should set the text"
    char *txt_given = "foo";
    char * text = mk_literal(100, txt_given).text;
    text should equal txt_given
  end

  it "should have type = 2"
    int type = mk_literal(100, "foo").type;
    type should equal LITERAL
  end

  it "should have the parse function as a pointer to literal_parse"
    node rule = mk_literal(100, "foo");
    rule.parse should equal parse_literal
  end
end

unsigned int reference_list[2];

describe "mk_rule"
  it "should have type = 1"
    node rule = mk_rule(100, reference_list);
    rule.type should equal RULE
  end

  it "should have the identifier"
    node rule = mk_rule(100, reference_list);
    rule.identifier should equal 100
  end

  it "should use the correct id"
    node rule = mk_rule(200, reference_list);
    rule.identifier should equal 200
  end

  it "should have a list of references"
    node rule = mk_rule(100, reference_list);
    rule.references should equal reference_list
  end

  it "should use the parse_rule function"
    node rule = mk_rule(100, reference_list);
    rule.parse should equal parse_rule
  end
end