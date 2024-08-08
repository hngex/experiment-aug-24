default: start

start: setup
	docker-compose build && docker-compose up

mail:
	./scripts/sendmail.sh

setup:
	touch logs/msa1.log
	touch logs/msa2.log
	touch logs/msa3.log
	touch logs/mx1.log
	touch logs/mx2.log
	touch logs/mx3.log

clean:
	docker-compose rm --force
	rm -rf logs/*.log
