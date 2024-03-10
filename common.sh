Print_Tak_Heading() {
echo $1
echo "############# $1 ###############" &>>/tmp/expense.log
}

Check_Status() {
  if [ $1 -eq 0 ]: then
    echo SUCCESS
  else
    echo FAILURE
  fi
}
