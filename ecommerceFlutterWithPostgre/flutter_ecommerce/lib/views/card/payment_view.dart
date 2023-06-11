import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/views/base_view.dart';

class PaymentView extends StatefulWidget {
  const PaymentView({Key? key}) : super(key: key);

  @override
  State<PaymentView> createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFEFF2),
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Container(
                padding: EdgeInsets.all(8.0),
                height: MediaQuery.of(context).size.width * 0.4,
                width: MediaQuery.of(context).size.width * 0.4,
                child: Center(
                  child: Icon(Icons.check_circle, color: const Color(0xFFEFEFF2),size: 50),
                ),
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(150.0),
                  border: Border.all(
                    color: Colors.white30,
                    width: 18,
                  ),
                ),
              ),
              height: MediaQuery.of(context).size.width * 0.4,
              width: MediaQuery.of(context).size.width * 0.4,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(150.0),
                color: Colors.orangeAccent,
                border: Border.all(
                  color: Colors.white70,
                  width: 18,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Tebrikler!!!",style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500),textAlign: TextAlign.center,),
          ),
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Ödeme başarıyla gerçekleştirildi. Anasayfaya dönerek yeni ürünleri inceleyebilirsiniz.",style: TextStyle(color: Colors.black54, fontSize: 18, fontWeight: FontWeight.w400),textAlign: TextAlign.center,),
          ),
          SizedBox(height: 30,),
          Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => BaseView(

                    )),
                        (Route<dynamic> route) => false,
                  );
                },
                style: ElevatedButton.styleFrom(
                    primary: Colors.orange,
                    shape: const StadiumBorder()),
                child: const Text("Anasayfa", style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
            ),
          )
        ],
      ),
    );
  }
}
