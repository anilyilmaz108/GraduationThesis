import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_brand.dart';
import 'package:flutter_credit_card/custom_card_type_icon.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:flutter_ecommerce/services/data_service.dart';
import 'package:flutter_ecommerce/services/database_service.dart';
import 'package:flutter_ecommerce/views/card/app_colors.dart';
import 'package:flutter_ecommerce/views/card/payment_view.dart';
import 'package:provider/provider.dart';

class CreditCardView extends StatefulWidget {
  const CreditCardView({Key? key}) : super(key: key);

  @override
  State<CreditCardView> createState() => _CreditCardViewState();
}

class _CreditCardViewState extends State<CreditCardView> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  bool useGlassMorphism = false;
  bool useBackgroundImage = false;
  OutlineInputBorder? border;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController _controller;

  @override
  void initState() {
    border = OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.grey.withOpacity(0.7),
        width: 2.0,
      ),
    );
    _controller = TextEditingController();
    super.initState();
  }
  @override
  void dispose() {
    _controller = TextEditingController();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Ödeme Ekranı'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: ExactAssetImage('assets/images/bg.png'),
            fit: BoxFit.fill,
          ),
          color: Colors.black,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: <Widget>[
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: TextField(
                      controller: _controller,
                      cursorColor: Colors.white70,
                      keyboardType: TextInputType.text,
                      onTap: null,
                      decoration: InputDecoration(
                        filled: true,
                        hintMaxLines: 5,
                        fillColor: _controller.text == "" || _controller.text  == null ? Colors.white : Colors.greenAccent,
                        contentPadding: const EdgeInsets.only(left: 8, bottom: 0, top: 0, right: 15),
                        hintText: _controller.text  == "" || _controller.text  == null ? "Adres bilgilerinizi giriniz" : _controller.text ,
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(8.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                  CreditCardWidget(
                    glassmorphismConfig:
                    useGlassMorphism ? Glassmorphism.defaultConfig() : null,
                    cardNumber: cardNumber,
                    expiryDate: expiryDate,
                    cardHolderName: cardHolderName,
                    cvvCode: cvvCode,
                    bankName: 'GiysiDolabı',
                    frontCardBorder:
                    !useGlassMorphism ? Border.all(color: Colors.grey) : null,
                    backCardBorder:
                    !useGlassMorphism ? Border.all(color: Colors.grey) : null,
                    showBackView: isCvvFocused,
                    obscureCardNumber: true,
                    obscureCardCvv: true,
                    isHolderNameVisible: true,
                    cardBgColor: Colors.black,
                    backgroundImage:
                    useBackgroundImage ? 'assets/images/card_bg.png' : null,
                    isSwipeGestureEnabled: true,
                    onCreditCardWidgetChange:
                        (CreditCardBrand creditCardBrand) {},
                    customCardTypeIcons: <CustomCardTypeIcon>[
                      CustomCardTypeIcon(
                        cardType: CardType.mastercard,
                        cardImage: Image.asset(
                          'assets/images/mastercard.png',
                          height: 48,
                          width: 48,
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          CreditCardForm(
                            formKey: formKey,
                            obscureCvv: true,
                            obscureNumber: true,
                            cardNumber: cardNumber,
                            cvvCode: cvvCode,
                            isHolderNameVisible: true,
                            isCardNumberVisible: true,
                            isExpiryDateVisible: true,
                            cardHolderName: cardHolderName,
                            expiryDate: expiryDate,
                            themeColor: Colors.blue,
                            textColor: Colors.white,
                            cardNumberDecoration: InputDecoration(
                              labelText: 'Kart Numarası',
                              hintText: 'XXXX XXXX XXXX XXXX',
                              hintStyle: const TextStyle(color: Colors.white),
                              labelStyle: const TextStyle(color: Colors.white),
                              focusedBorder: border,
                              enabledBorder: border,
                            ),
                            expiryDateDecoration: InputDecoration(
                              hintStyle: const TextStyle(color: Colors.white),
                              labelStyle: const TextStyle(color: Colors.white),
                              focusedBorder: border,
                              enabledBorder: border,
                              labelText: 'Tarih',
                              hintText: 'XX/XX',
                            ),
                            cvvCodeDecoration: InputDecoration(
                              hintStyle: const TextStyle(color: Colors.white),
                              labelStyle: const TextStyle(color: Colors.white),
                              focusedBorder: border,
                              enabledBorder: border,
                              labelText: 'CVV',
                              hintText: 'XXX',
                            ),
                            cardHolderDecoration: InputDecoration(
                              hintStyle: const TextStyle(color: Colors.white),
                              labelStyle: const TextStyle(color: Colors.white),
                              focusedBorder: border,
                              enabledBorder: border,
                              labelText: 'Kart Sahibi',
                            ),
                            onCreditCardModelChange: onCreditCardModelChange,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                const Text(
                                  'Şeffaflık',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                                const Spacer(),
                                Switch(
                                  value: useGlassMorphism,
                                  inactiveTrackColor: Colors.grey,
                                  activeColor: Colors.white,
                                  activeTrackColor: AppColors.colorE5D1B2,
                                  onChanged: (bool value) => setState(() {
                                    useGlassMorphism = value;
                                  }),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                const Text(
                                  'Kart Resmi',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                                const Spacer(),
                                Switch(
                                  value: useBackgroundImage,
                                  inactiveTrackColor: Colors.grey,
                                  activeColor: Colors.white,
                                  activeTrackColor: AppColors.colorE5D1B2,
                                  onChanged: (bool value) => setState(() {
                                    useBackgroundImage = value;
                                  }),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          GestureDetector(
                            onTap: _onValidate,
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: <Color>[
                                    AppColors.colorB58D67,
                                    AppColors.colorB58D67,
                                    AppColors.colorE5D1B2,
                                    AppColors.colorF9EED2,
                                    AppColors.colorFFFFFD,
                                    AppColors.colorF9EED2,
                                    AppColors.colorB58D67,
                                  ],
                                  begin: Alignment(-1, -4),
                                  end: Alignment(1, 4),
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              width: double.infinity,
                              alignment: Alignment.center,
                              child: const Text(
                                'Satın Al',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'halter',
                                  fontSize: 14,
                                  package: 'flutter_credit_card',
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onValidate()  {
    if (formKey.currentState!.validate()){
      print('ADDRESS::  ${_controller.text}');
      Provider.of<DatabaseService>(context, listen: false).postPurchased(DateTime.now(), FirebaseAuth.instance.currentUser!.email.toString(), DataService.totalCost, _controller.text, DataService.productStringArray);
      Navigator.push(context, MaterialPageRoute(builder: (context) => const PaymentView()));
    } else {
      const snackBar = SnackBar(
        content: Text('Hatalı Kart Bilgileri!!!'),
        backgroundColor: Colors.red,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  void onCreditCardModelChange(CreditCardModel? creditCardModel) {
    setState(() {
      cardNumber = creditCardModel!.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }


}

