import 'package:mpos/base/base.dart';
import 'package:mpos/constants/app_constants.dart';
import 'package:mpos/widgets/dotted_line.dart';

class FormReceipt extends StatelessWidget {
  final GlobalKey repaintBoundaryKey;
  final List<Map<String, dynamic>> items;
  const FormReceipt({super.key, required this.repaintBoundaryKey, required this.items});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        SingleChildScrollView(
          child: RepaintBoundary(
            key: repaintBoundaryKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const ReceiptHeader(
                  customerName: 'Huỳnh Ngọc Liên',
                  createdDate: '22/11/2022',
                  branch: '2',
                  staffName: 'Huỳnh bảo Ngọc',
                ),
                ReceiptBody(
                  currentIndex: 1,
                  items: items,
                ),
                const ReceiptFooter(),
              ],
            ),
          ),
        ),
        Positioned.fill(
          child: Container(color: ColorsApp.wiserink20),
        ),
      ],
    );
  }
}

class ReceiptHeader extends StatelessWidget {
  final String customerName;
  final String createdDate;
  final String branch;
  final String staffName;
  const ReceiptHeader(
      {super.key,
      required this.customerName,
      required this.createdDate,
      required this.branch,
      required this.staffName});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          RowInformation(
            title: language.customer,
            content: customerName,
            isBold: true,
          ),
          RowInformation(
            title: language.createdDate,
            content: createdDate,
            isBold: true,
          ),
          RowInformation(
            title: language.branch,
            content: branch,
            isBold: true,
          ),
          RowInformation(
            title: language.staff,
            content: staffName,
            isBold: true,
          ),
          const SizedBox(height: 5),
          Text(
            '5 ${language.product.toLowerCase()}',
            textScaleFactor: 1.0,
            style: const TextStyle(
              fontFamily: font,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

class ReceiptBody extends StatelessWidget {
  final int currentIndex;
  final List<Map<String, dynamic>> items;
  const ReceiptBody({super.key, required this.currentIndex, required this.items});

  @override
  Widget build(BuildContext context) {
    int index = currentIndex;
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: items.map(
          (item) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '${index++}. ',
                  textScaleFactor: 1.0,
                  style: const TextStyle(
                    height: 1.5,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        item["header"],
                        textScaleFactor: 1.0,
                        style: const TextStyle(
                          height: 1.5,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 5),
                      RowInformation(
                        title: language.sku,
                        content: item["sku"],
                        isBold: true,
                      ),
                      RowInformation(
                        title: language.unit,
                        content: item["unit"],
                      ),
                      RowInformation(
                        title: language.price,
                        content: item["price"],
                      ),
                      RowInformation(
                        title: language.quantity,
                        content: item["quantity"],
                      ),
                      RowInformation(
                        title: language.totalPrice,
                        content: item["total"],
                        isBold: true,
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ).toList(),
      ),
    );
  }
}

class ReceiptFooter extends StatelessWidget {
  const ReceiptFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 10),
          const DottedLine(
            dashColor: ColorsApp.wiserink100,
          ),
          const SizedBox(height: 15),
          RowInformation(
            title: language.subTotal,
            content: '1.800.000 đ',
            isBold: false,
          ),
          RowInformation(
            title: language.discount,
            content: '50.000 đ',
            isBold: false,
          ),
          RowInformation(
            title: language.total,
            content: '1.950.000 đ',
            isBold: true,
          ),
          RowInformation(
            title: language.paymentMethod,
            content: 'Tiền mặt',
            isBold: false,
          ),
          RowInformation(
            title: language.paymentTime,
            content: '16/8/2022',
            isBold: false,
          ),
        ],
      ),
    );
  }
}

class RowInformation extends StatelessWidget {
  final String title;
  final double titleSize;
  final String content;
  final bool isBold;
  final double contentSize;
  const RowInformation(
      {super.key,
      required this.title,
      required this.content,
      this.titleSize = 16,
      this.isBold = false,
      this.contentSize = 14});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 5),
      child: Row(
        children: <Widget>[
          Text(
            title,
            textScaleFactor: 1.0,
            style: TextStyle(
              fontFamily: font,
              fontSize: titleSize,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                content,
                textScaleFactor: 1.0,
                style: TextStyle(
                  fontFamily: font,
                  fontSize: contentSize,
                  fontWeight: isBold ? FontWeight.w600 : FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
