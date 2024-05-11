# Автоматическая сборка проекта при изменении файлов
watch:
	modd

# Сборка проекта
build:
	go build -o bin/grpc cmd/grpc/main.go

# Скачивание proto google
proto-google:
	curl https://raw.githubusercontent.com/googleapis/googleapis/974ad5bdfc9ba768db16b3eda2850aadd8c10a2c/google/api/annotations.proto --create-dirs -o api/google/api/annotations.proto
	curl https://raw.githubusercontent.com/googleapis/googleapis/974ad5bdfc9ba768db16b3eda2850aadd8c10a2c/google/api/http.proto --create-dirs -o api/google/api/http.proto

# Название пакета
PACKAGE=$(shell awk 'NR==1 {print $$2}' go.mod)

# Генерация кода
generate:
	protoc -Iapi \
	  --go_opt=module=$(PACKAGE) --go_out=. \
	  --go-grpc_opt=module=$(PACKAGE) --go-grpc_out=. \
	  --grpc-gateway_opt=module=$(PACKAGE) --grpc-gateway_out=. \
	  api/microservice/v1/*.proto
