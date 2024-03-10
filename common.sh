Print_Tak_Heading() {
echo $1
echo "############# $1 ###############" &>>/tmp/expense.log
}

Check_Status() {
  if [ $1 -eq 0 ]; then
    echo -e "\e[32mSUCCESS\e[0m"
  else
    echo -e "\e[31mFAILURE\e[0m"
  fi
}
