#RMFILES = pan.* *.trail f13 f18

#clean:
#	rm -f $(RMFILES)
#	clear

# If the first argument is "run"...

# TODO edit to set up system, not just be a template
ifeq (push,$(firstword $(MAKECMDGOALS)))
  # use the rest as arguments for "run"
  MESSAGE := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
  # ...and turn them into do-nothing targets
  $(eval $(MESSAGE):;@:)
endif

push:
#	rm -f $(RMFILES)
	git commit -am $(MESSAGE) && git pull && git push

