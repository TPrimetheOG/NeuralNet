CXX = g++ -std=c++20
CXXFLAGS = -I D:/Softwares/eigen-3.4.0
LDFLAGS = -lws2_32

TARGET = main
SRC = main.cpp

all: $(TARGET)

$(TARGET): $(SRC)
	$(CXX) $(CXXFLAGS) -o $(TARGET) $(SRC) $(LDFLAGS)

clean:
	rm -f $(TARGET)
