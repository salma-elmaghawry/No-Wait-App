import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:no_wait/core/animations/animations.dart';
import 'package:no_wait/core/helpers/app_validators.dart';
import 'package:no_wait/core/helpers/extensions.dart';
import 'package:no_wait/core/helpers/spacing.dart';
import 'package:no_wait/core/routes/routes.dart';
import 'package:no_wait/core/utils/app_text_styles.dart';
import 'package:no_wait/core/widgets/phone_number_field.dart';
import 'package:no_wait/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:no_wait/features/auth/presentation/cubit/auth_state.dart';
import 'package:no_wait/features/auth/presentation/models/auth_flow_args.dart';
import 'package:no_wait/features/auth/presentation/widgets/auth_top_bar.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  void _submit() {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState?.validate() ?? false) {
      context.read<AuthCubit>().sendOtp(phone: _phoneController.text.trim());
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            AuthTopBar(title: 'auth.signup.appbar_title'.tr()),
            Expanded(
              child: BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) {
                  if (state.action != AuthAction.sendOtp) return;
                  if (state.isFailure && state.message != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.message!),
                        backgroundColor: colorScheme.error,
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  } else if (state.isSuccess) {
                    context.pushNamed(
                      Routes.otpVerification,
                      arguments: OtpVerificationArgs(
                        phone: _phoneController.text.trim(),
                        flow: OtpFlow.register,
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  final isLoading =
                      state.isLoading && state.action == AuthAction.sendOtp;

                  return SingleChildScrollView(
                    padding: EdgeInsetsDirectional.symmetric(horizontal: 24.w),
                    child: Form(
                      key: _formKey,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          verticalSpace(16),
                          Text(
                            'auth.signup.title'.tr(),
                            style: AppTextStyles.font24Bold.copyWith(
                              color: colorScheme.onSurface,
                            ),
                          ).fadeInSlideUp(),
                          verticalSpace(6),
                          Text(
                            'auth.signup.subtitle'.tr(),
                            style: AppTextStyles.font14Normal.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ).fadeInSlideUp(delay: AppAnimations.staggerDelay),
                          verticalSpace(28),
                          PhoneNumberField(
                            label: 'auth.login.phone_label'.tr(),
                            hint: 'auth.login.phone_hint'.tr(),
                            controller: _phoneController,
                            validator: AppValidators.validatePhone,
                          ).fadeInSlideUp(
                            delay: AppAnimations.staggerDelay * 2,
                          ),
                          verticalSpace(32),
                          AnimatedButton(
                            height: 52.h,
                            isLoading: isLoading,
                            backgroundColor: colorScheme.secondary,
                            borderRadius: BorderRadius.circular(16.r),
                            onPressed: _submit,
                            child: Center(
                              child: Text(
                                'auth.signup.button'.tr(),
                                style: AppTextStyles.font16Normal.copyWith(
                                  color: colorScheme.onSecondary,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ).fadeInSlideUp(
                            delay: AppAnimations.staggerDelay * 3,
                          ),
                          verticalSpace(20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'auth.signup.have_account'.tr(),
                                style: AppTextStyles.font14Normal.copyWith(
                                  color: colorScheme.onSurfaceVariant,
                                ),
                              ),
                              horizontalSpace(4),
                              AnimatedTap(
                                onTap: () =>
                                    context.pushReplacementNamed(Routes.login),
                                child: Text(
                                  'auth.signup.login_link'.tr(),
                                  style: AppTextStyles.font14SemiBold.copyWith(
                                    color: colorScheme.secondary,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ],
                          ).fadeInSlideUp(
                            delay: AppAnimations.staggerDelay * 4,
                          ),
                          verticalSpace(24),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
