import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/theme/app_spacing.dart';
import '../../../../app/widgets/app_screen.dart';
import '../../../../app/widgets/app_text_field.dart';
import '../../domain/models/profile_models.dart';
import '../cubit/personal_info_cubit.dart';

class PersonalInfoPage extends StatefulWidget {
  const PersonalInfoPage({super.key});

  @override
  State<PersonalInfoPage> createState() => _PersonalInfoPageState();
}

class _PersonalInfoPageState extends State<PersonalInfoPage> {
  final _name = TextEditingController();
  final _title = TextEditingController();
  final _email = TextEditingController();
  final _phone = TextEditingController();
  final _location = TextEditingController();
  final _linkedin = TextEditingController();
  final _github = TextEditingController();
  final _portfolio = TextEditingController();
  bool _seeded = false;

  @override
  void dispose() {
    _name.dispose();
    _title.dispose();
    _email.dispose();
    _phone.dispose();
    _location.dispose();
    _linkedin.dispose();
    _github.dispose();
    _portfolio.dispose();
    super.dispose();
  }

  void _seed(PersonalInfo info) {
    if (_seeded) return;
    _seeded = true;
    _name.text = info.fullName;
    _title.text = info.title;
    _email.text = info.email;
    _phone.text = info.phone;
    _location.text = info.location;
    _linkedin.text = info.linkedin;
    _github.text = info.github;
    _portfolio.text = info.portfolio;
  }

  PersonalInfo _fromControllers() {
    return PersonalInfo(
      fullName: _name.text,
      title: _title.text,
      email: _email.text,
      phone: _phone.text,
      location: _location.text,
      linkedin: _linkedin.text,
      github: _github.text,
      portfolio: _portfolio.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PersonalInfoCubit, PersonalInfoState>(
      listenWhen: (prev, next) => next.ready && !prev.ready,
      listener: (context, state) => _seed(state.info),
      builder: (context, state) {
        if (state.ready) _seed(state.info);
        final cubit = context.read<PersonalInfoCubit>();
        void persist() {
          if (!state.ready) return;
          cubit.onChanged(_fromControllers());
        }

        return AppScreen(
          title: 'Personal info',
          showSaved: state.saved,
          primaryLabel: 'Done',
          onPrimary: () async {
            persist();
            await cubit.flushPending();
            if (context.mounted) context.pop();
          },
          body: ListView(
            padding: const EdgeInsets.all(AppSpacing.screenPadding),
            children: [
              AppTextField(
                label: 'Name',
                hint: 'Jane Doe',
                controller: _name,
                keyboardType: TextInputType.name,
                textCapitalization: TextCapitalization.words,
                autofillHints: const [AutofillHints.name],
                prefixIcon: Icons.person_outline_rounded,
                onChanged: (_) => persist(),
              ),
              const SizedBox(height: AppSpacing.md),
              AppTextField(
                label: 'Title',
                hint: 'Product designer',
                controller: _title,
                prefixIcon: Icons.badge_outlined,
                onChanged: (_) => persist(),
              ),
              const SizedBox(height: AppSpacing.md),
              AppTextField(
                label: 'Email',
                hint: 'you@email.com',
                controller: _email,
                keyboardType: TextInputType.emailAddress,
                autofillHints: const [AutofillHints.email],
                textCapitalization: TextCapitalization.none,
                onChanged: (_) => persist(),
              ),
              const SizedBox(height: AppSpacing.md),
              AppTextField(
                label: 'Phone',
                hint: '+1 555 010 0100',
                controller: _phone,
                keyboardType: TextInputType.phone,
                autofillHints: const [AutofillHints.telephoneNumber],
                textCapitalization: TextCapitalization.none,
                onChanged: (_) => persist(),
              ),
              const SizedBox(height: AppSpacing.md),
              AppTextField(
                label: 'Location',
                hint: 'Austin, TX',
                controller: _location,
                keyboardType: TextInputType.streetAddress,
                autofillHints: const [AutofillHints.addressCity],
                onChanged: (_) => persist(),
              ),
              const SizedBox(height: AppSpacing.md),
              AppTextField(
                label: 'LinkedIn',
                hint: 'linkedin.com/in/janedoe',
                controller: _linkedin,
                keyboardType: TextInputType.url,
                textCapitalization: TextCapitalization.none,
                onChanged: (_) => persist(),
              ),
              const SizedBox(height: AppSpacing.md),
              AppTextField(
                label: 'GitHub',
                hint: 'github.com/janedoe',
                controller: _github,
                keyboardType: TextInputType.url,
                textCapitalization: TextCapitalization.none,
                onChanged: (_) => persist(),
              ),
              const SizedBox(height: AppSpacing.md),
              AppTextField(
                label: 'Portfolio',
                hint: 'janedoe.com',
                controller: _portfolio,
                keyboardType: TextInputType.url,
                textInputAction: TextInputAction.done,
                textCapitalization: TextCapitalization.none,
                onChanged: (_) => persist(),
              ),
            ],
          ),
        );
      },
    );
  }
}
