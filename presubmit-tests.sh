
function check() {

  local exit_code=0
  pip3 install virtualenv

  virtualenv -p python3 sandbox
  source sandbox/bin/activate
  pip3 install -r requirements.txt

  mypy src/ test/ > errors.txt

  if [ -s errors.txt ]
  then
    awk 'BEGIN { print "\n"} { print $0} END { print "\n" NR " Type Errors found"}' < errors.txt
    exit_code=1
  else
    ls test/*.py | PYTHONPATH=./src:./test xargs python
    exit_code=$?
  fi

  deactivate

  return $exit_code
}

check
readonly exit_code=$?

rm -rf sandbox
rm -rf errors.txt
rm -rf */__pycache__

exit $exit_code
