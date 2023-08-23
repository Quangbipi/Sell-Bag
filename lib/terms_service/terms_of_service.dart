import 'package:flutter/material.dart';

class TermOfService extends StatelessWidget {
  const TermOfService({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms of Service'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Terms of Service',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
              const Text('    Welcome to the bag selling app! '
                  'Before using this app, please read and understand the terms below carefully. '
                  'By accessing and using this app, you agree to abide by the following terms and conditions:',
                style: TextStyle(fontSize: 18),),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    const Text('1. Terms and Conditions: By using this app, '
                        'you accept and agree to abide by all of the terms and conditions set forth below. '
                        'If you do not agree to any of the terms, stop using the application immediately.',
                      style: TextStyle(fontSize: 18),),
                    const Text('2. Service Description: Handbag sales app that provides you with '
                        'information about handbag products'
                        ' and allows you to purchase online. '
                        'We provide product information such as images, descriptions, '
                        'prices and other information to help you have a convenient shopping experience.',
                      style: TextStyle(fontSize: 18),),
                    const Text('3. Copyright and intellectual property: The materials, content and design in this application are the property of us or of third parties licensed to us. '
                        'You may not copy, distribute, reproduce, or use any part of the Content without written permission from us.'
                      ,style: TextStyle(fontSize: 18),),
                    const Text('4. Information Security: We are committed to protecting your personal information in accordance with the Privacy Policy. '
                        'However, the transmission of information over the Internet is not completely secure, and we do not guarantee the absolute security of the information you provide.',style: TextStyle(fontSize: 18),),
                    const Text('5. User responsibility: You are responsible for ensuring that the information you provide when registering and using the application is accurate and does not infringe the rights of any third party. '
                        'You are also responsible for maintaining your password and not sharing it with anyone else.',style: TextStyle(fontSize: 18),),
                    const Text('6. Giới hạn trách nhiệm: Chúng tôi không chịu trách nhiệm đối với bất kỳ thiệt hại trực tiếp, gián tiếp, ngẫu nhiên hoặc phạt phá nào phát sinh từ việc sử dụng hoặc không thể sử dụng ứng dụng này.',style: TextStyle(fontSize: 18),),
                    const Text('7. Modify terms: We reserve the right to amend these terms and conditions at any time. '
                        'Any amendments will be effective immediately upon approval.'
                        'The terms and conditions of the handbag sale application may vary depending on the legal requirements and the specifics of the application.',
                      style: TextStyle(fontSize: 18),),
                    TextButton(
                      style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Theme.of(context).primaryColor
                        ),
                      ),
                      onPressed: (){
                        Navigator.pop(context);
                        print("click");
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(6),
                        child: Text(
                          'I agree',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        )
      )
    );
  }
}
