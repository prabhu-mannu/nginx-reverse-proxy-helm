.PHONY: install install-dep  update install-ingress clean

update:
	helm upgrade --install nginx-demo nginx
	kubectl rollout status deployment nginx-demo
	helm ls

install:
	helm install --name=nginx-demo nginx
	kubectl rollout status deployment nginx-demo
	helm ls

install-with-ssl:
	make generate-dummy-ssl
	make install-dummy-ssl
	helm upgrade --install nginx-demo nginx --set ingress.tlsEnabled=true

install-ingress:
	helm install stable/nginx-ingress --name ingress --namespace ingress
	helm ls

install-demo-upstream:
	kubectl apply -f https://raw.githubusercontent.com/istio/istio/master/samples/httpbin/httpbin.yaml

test-deployment-http:
	curl http://127.0.0.1.nip.io/headers

test-deployment-https:
	curl https://127.0.0.1.nip.io/headers -k

generate-dummy-ssl:
	mkdir -p ssl
	cd ssl
	openssl req -x509 -newkey rsa:2048 -keyout key.pem -out cert.pem -days 365 -subj '/CN=127.0.0.1.nip.io' -nodes

install-dummy-ssl:
	cd ssl
	kubectl create  secret tls --dry-run -o yaml --key key.pem --cert cert.pem localhost-tls | kubectl apply -f -


clean:
	rm -rf ssl
	helm delete nginx-demo --purge || echo " nginx-demo delete failed"
	helm delete ingress --purge || echo " ingress delete failed"
	kubectl delete  secret localhost-tls || echo " secret localhost-tls  delete failed"

