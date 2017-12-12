PROG     = a
SRC_DIR  = .
INC_DIR  = .
LIB_DIR  = .
OUT_DIR  = build
CPPFLAGS = -I $(INC_DIR)
CXXFLAGS = -std=c++17
LDFLAGS = -L $(LIB_DIR)

SRCS = $(addprefix $(SRC_DIR)/, $(wildcard *.cpp))
DEPS = $(addprefix $(OUT_DIR)/, $(SRCS:%.cpp=%.d))
OBJS = $(addprefix $(OUT_DIR)/, $(SRCS:%.cpp=%.o))
TARGET = ./$(PROG)

.PHONY: all clean
all: $(TARGET)

-include $(DEPS)

$(TARGET): $(OBJS)
	$(CXX) $(LDFLAGS) -o $@ $(OBJS)

$(OUT_DIR)/%.o: %.cpp
	@mkdir -p $(OUT_DIR)
	$(CXX) -c $(CPPFLAGS) $(CXXFLAGS) $(LDFLAGS) -MMD -MP -o $@ $<

.PHONY: clean
clean:
	$(RM) -r $(TARGET) $(OUT_DIR) *.tmp

# vim: noexpandtab

