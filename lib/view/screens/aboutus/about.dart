import 'package:flutter/material.dart';

import 'package:pppcalculator/view/widgets/drawer_menu_widget.dart';
import 'package:pppcalculator/constants.dart' as Constants;

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({super.key});

  @override
  State<AboutUsPage> createState() => _AboutUsPage();
}

class _AboutUsPage extends State<AboutUsPage> {
  gapBetween() => const SizedBox(
    height: 25,
  );

  var imageAsset;

  @override
  void initState() {
    super.initState();

    imageAsset = AssetImage("assets/images/phoenix.png");
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerMenuWidget(),
      appBar: AppBar(
        centerTitle: true,
        title: const Text(Constants.APP_TITLE),
        backgroundColor: Colors.grey,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image(image: imageAsset),
              SizedBox(height: 35),
              Text(
                'Phoenix Info Systems LLP',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              SizedBox(height: 20),
              RichText(
                text: TextSpan(
                  text: ' Phoenix ',
                  style: Theme.of(context).textTheme.bodyMedium,
                  children: [
                    TextSpan(
                      text: 'is an award-winning creative mobile app company driven by ',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const TextSpan(
                      text: 'Master Yajjurved and Miss Samradni. ',
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                    TextSpan(
                      text: ' Our mission is to provide high-quality products and services to our customers.',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),

                
              ),
              SizedBox(height: 18),
              Text(
                'Founded in 2023, we have been serving the community for over 1 year. We are proud to have received numerous recognition for our products and customer service.',
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
