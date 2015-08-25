OBJS = clientSocket.o connectedSocket.o serverSocket.o
SRCS = clientSocket.cpp connectedSocket.cpp serverSocket.cpp
INCL = clientSocket.h connectedSocket.h serverSocket.h libsocket.h
FLAGS = -fpermissive -fPIC

all: $(OUT)

libsocket.so: $(OBJS)
	g++ -shared $(OBJS) -o libsocket.so

libsocket.dylib: $(OBJS)
	libtool -dynamic -flat_namespace -install_name /usr/lib/libsocket.dylib  -lSystem -compatibility_version 1.0 -current_version 1.0.0  -undefined suppress $(OBJS) -o libsocket.dylib -macosx_version_min 10.6

clientSocket.o: $(SRCS)
	g++ -o clientSocket.o -c clientSocket.cpp $(FLAGS)

connectedSocket.o: $(SRCS)
	g++ -o connectedSocket.o -c connectedSocket.cpp $(FLAGS)

serverSocket.o: $(SRCS)
	g++ -o serverSocket.o -c serverSocket.cpp $(FLAGS)

install: $(OUT) $(INCL)
	cp $(OUT) /usr/lib/
	mkdir -p /usr/include/libsocket/
	cp clientSocket.h /usr/include/libsocket/
	cp connectedSocket.h /usr/include/libsocket/
	cp serverSocket.h /usr/include/libsocket/
	cp libsocket.h /usr/include/libsocket/

clean:
	rm -rf $(OBJS) $(OUT)
