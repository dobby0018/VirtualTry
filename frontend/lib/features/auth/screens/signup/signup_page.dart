import 'package:flutter/material.dart';
import 'package:flutter_vto_project/utils/constants/image_strings.dart';
import 'package:flutter_vto_project/utils/constants/sizes.dart';
import 'package:flutter_vto_project/utils/constants/text_strings.dart';
import 'package:flutter_vto_project/utils/helpers/helper_functions.dart';
import 'package:iconsax/iconsax.dart';
import 'package:flutter_vto_project/features/auth/screens/home/home_page.dart';
import 'package:flutter_vto_project/navigation_menu.dart';
import 'package:flutter_vto_project/utils/validators/validation.dart';
import 'package:get/get.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            top: TSizes.appBarHeight,
            left: TSizes.defaultSpace,
            bottom: TSizes.defaultSpace,
            right: TSizes.defaultSpace,
          ),
          child: Column(
            children: [
              /// Logo, Title & Sub-Title
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    TTexts.signupTitle,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: TSizes.sm),
                ],
              ),

              /// Form
              Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,

                child: Column(
                  children: [
                    /// First Name & Last Name
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Iconsax.user),
                              labelText: TTexts.firstName,
                            ),
                          ),
                        ),
                        const SizedBox(width: TSizes.spaceBtwInputFields),
                        Expanded(
                          child: TextFormField(
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Iconsax.user),
                              labelText: TTexts.lastName,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: TSizes.spaceBtwInputFields),

                    /// Username
                    TextFormField(
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Iconsax.user_edit),
                        labelText: TTexts.username,
                      ),
                    ),
                    const SizedBox(height: TSizes.spaceBtwInputFields),

                    /// Email
                    TextFormField(
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Iconsax.direct),
                        labelText: TTexts.email,
                      ),
                      validator: TValidator.validateEmail,
                    ),
                    const SizedBox(height: TSizes.spaceBtwInputFields),

                    /// Phone Number
                    TextFormField(
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Iconsax.call),
                        labelText: TTexts.phoneNo,
                      ),
                      validator: TValidator.validatePhoneNumber,
                    ),
                    const SizedBox(height: TSizes.spaceBtwInputFields),

                    /// Password
                    TextFormField(
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Iconsax.password_check),
                        labelText: TTexts.password,
                        suffixIcon: Icon(Iconsax.eye_slash),
                      ),
                      obscureText: true,
                      validator: TValidator.validatePassword,
                    ),
                    const SizedBox(height: TSizes.spaceBtwSections),

                    /// Terms & Conditions Checkbox
                    Row(
                      children: [
                        Checkbox(value: true, onChanged: (value) {}),
                        const SizedBox(width: TSizes.spaceBtwItems),
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: '${TTexts.agreeTo} ',
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                TextSpan(
                                  text: TTexts.privacyPolicy,
                                  style: Theme.of(
                                    context,
                                  ).textTheme.bodySmall!.copyWith(
                                    color: Colors.blue,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                                TextSpan(
                                  text: TTexts.termsOfUse,
                                  style: Theme.of(
                                    context,
                                  ).textTheme.bodySmall!.copyWith(
                                    color: Colors.blue,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: TSizes.spaceBtwSections),

                    /// Create Account Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const NavigationMenu(),
                            ),
                          );
                        },

                        child: const Text(TTexts.createAccount),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
