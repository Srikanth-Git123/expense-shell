source common.sh

app_dir=/usr/share/nginx/html
componenent=frontend

Print_Task_Heading "Install Nginx"
dnf install nginx -y &>>$LOG
Check_Status $?

Print_Task_Heading "Copy Expense Nginx Configuration"
cp expense.conf /etc/nginx/default.d/expense.conf &>>$LOG
Check_Status $?

App_PreReq

Print_Task_Heading "Start Nginx Service"
systemctl enable nginx &>>$LOG
systemctl restart nginx &>>$LOG
Check_Status $?
