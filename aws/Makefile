create:
	aws secretsmanager create-secret --name my-password --secret-string "password1234"
	aws secretsmanager create-secret --name my-username --secret-string "user123"
	aws secretsmanager create-secret --name my-json-credential \
		--secret-string '{"host":"example.db.local","port":"3128","user":"admin","password":"trollolol123"}'

show:
	aws secretsmanager get-secret-value --secret-id my-username
	aws secretsmanager get-secret-value --secret-id my-password
	aws secretsmanager get-secret-value --secret-id my-json-credential

cleanup:
	aws secretsmanager delete-secret --secret-id my-password --force-delete-without-recovery --region eu-central-1
	aws secretsmanager delete-secret --secret-id my-username --force-delete-without-recovery --region eu-central-1
	aws secretsmanager delete-secret --secret-id my-json-credential --force-delete-without-recovery --region eu-central-1
	aws secretsmanager delete-secret --secret-id my-best-pokemon --force-delete-without-recovery --region eu-central-1

show-pokedex:
	aws secretsmanager get-secret-value --secret-id my-best-pokemon

show-ecr:
	kubectl get secret ecr-secret -o yaml | yq .data
