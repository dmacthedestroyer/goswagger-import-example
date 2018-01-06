default: build

goodimport: clean
	mkdir -p goswagger-generated
	swagger generate server -f ./swagger.yml -t ./goswagger-generated --template-dir ./templates --config-file ./goswagger-config-goodimport.yml

badimport: clean
	mkdir -p goswagger-generated
	swagger generate server -f ./swagger.yml -t ./goswagger-generated --template-dir ./templates --config-file ./goswagger-config-badimport.yml

clean:
	rm -rf ./goswagger-generated
