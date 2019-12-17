A disparate collection of small scripts to automate certain processes or
make my life easier.

* epoch -- Bash script to convert input epoch to human-readable; print current
	time in epoch if no input was supplied

* photon.sh -- Bash script that runs [Photon OSINT tool](https://github.com/s0md3v/Photon) on the
   specified site.  Calling the tool is a bit cumbersome as it runs from a
   Docker container and you need to mount a local dir inside the container
   in order to save the results easily

* update_repos.sh -- Bash script that can recursively update all local git
    repositories from their origin repo (ie. git pull)

* xml_pretty_print.py -- Python script to make 1-liner input string more human-readable. <br>
    Majority of content cloned from
		https://stackoverflow.com/questions/3973819/python-pretty-xml-printer-for-xml-string

