import 'package:HealthAndBeauty/bloc/app_bloc.dart';
import 'package:HealthAndBeauty/components/events/components_events.dart';
import 'package:HealthAndBeauty/helpers/custom_colors.dart';
import 'package:HealthAndBeauty/model/component.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ComponentWidget extends StatelessWidget {
  final int index;
  final Component component;
  ComponentWidget(this.index, this.component);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      trailing: IconButton(
        onPressed: () {
          BlocProvider.of<AppBloc>(context).componentsBloc.add(DeleteComponentEvent(component, index));
        },
        icon: Icon(CupertinoIcons.trash, color: Colors.redAccent),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 29),
      leading: Container(
        alignment: Alignment.center,
        width: 34,
        height: 34,
        decoration: BoxDecoration(
            border: Border.all(width: 1, color: Color(0x80464646)),
            borderRadius: BorderRadius.all(Radius.circular(34))),
        child: Text(
          "0${index + 1}",
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.normal,
              color: Color(0x80464646)),
          textAlign: TextAlign.center,
        ),
      ),
      title: Text(
        component.name,
        style: TextStyle(
            color: UiColors.textMain,
            fontSize: 18,
            fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        "${component.price} SDG",
        style: TextStyle(
            color: UiColors.main, fontSize: 12, fontWeight: FontWeight.w500),
      ),
    );
  }
}
