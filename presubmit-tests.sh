pip3 install virtualenv

virtualenv -p python3 sandbox

source sandbox/bin/activate

pip3 install -r requirements.txt

#python src/test.py

mypy src/ > errors.txt

deactivate

if [ -s errors.txt ]
then
  echo "ERRORS FOUND:"
  cat errors.txt
  rm -f errors.txt
  exit 1
else
  echo "ALL PRE-CHECKS PASSED"
  exit 0
fi
