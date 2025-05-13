import 'package:flutter/material.dart';
import 'package:groceries/core/const/colors/app_colors.dart';
import 'package:groceries/core/const/strings/text_styles.dart';
import 'package:groceries/core/const/utils/app_responsive.dart';
import 'package:groceries/features/profile/presentation/widget/transaction_widget.dart' show TransactionItemWidget;

class TransactionsPage extends StatelessWidget {
  const TransactionsPage({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> transactions = const [
    {'icon': 'assets/images/mastercard.png', 'type': 'Master Card', 'dateTime': 'Dec 12 2021 at 10:00 pm', 'amount': '\$89', 'iconBg': Color(0xffFFE9E5)},
    {'icon': 'assets/images/mastercard.png', 'type': 'Visa Card', 'dateTime': 'Dec 12 2021 at 10:00 pm', 'amount': '\$109', 'iconBg': Color(0xffE5F7FF)},
    {'icon': 'assets/images/mastercard.png', 'type': 'Paypal', 'dateTime': 'Dec 12 2021 at 10:00 pm', 'amount': '\$567', 'iconBg': Color(0xffE5FFFB)},
    {'icon': 'assets/images/mastercard.png', 'type': 'Paypal', 'dateTime': 'Dec 12 2021 at 10:00 pm', 'amount': '\$567', 'iconBg': Color(0xffE5FFFB)},
    {'icon': 'assets/images/mastercard.png', 'type': 'Visa Card', 'dateTime': 'Dec 12 2021 at 10:00 pm', 'amount': '\$109', 'iconBg': Color(0xffE5F7FF)},
    {'icon': 'assets/images/mastercard.png', 'type': 'Master Card', 'dateTime': 'Dec 12 2021 at 10:00 pm', 'amount': '\$89', 'iconBg': Color(0xffFFE9E5)},
  ];

  @override
  Widget build(BuildContext context) {
    AppResponsive.init(context);
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.appBarTheme.backgroundColor,
        elevation: 0,
        title: Text(
          'Transactions',
          style: theme.textTheme.headlineMedium?.copyWith(fontSize: appWidth(5), color: theme.appBarTheme.foregroundColor),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: theme.appBarTheme.foregroundColor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(vertical: appHeight(2)),
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          final transaction = transactions[index];
          return TransactionItemWidget(
            iconPath: transaction['icon'],
            type: transaction['type'],
            dateTime: transaction['dateTime'],
            amount: transaction['amount'],
            iconBackgroundColor: transaction['iconBg'],
          );
        },
      ),
    );
  }
}
