LOG=/tmp/expense.log

Print_Task_Heading() {
echo $1
echo "############# $1 ###############" &>>LOG
}

Check_Status() {
  if [ $1 -eq 0 ]; then
    echo -e "\e[32mSUCCESS\e[0m"
  else
    echo -e "\e[31mFAILURE\e[0m"
    exit 2
  fi
}
