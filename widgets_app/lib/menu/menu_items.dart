import 'package:flutter/material.dart';

class MenuItem {
  final String title;
  final String subTitle;
  final String link;
  final IconData icon;

  const MenuItem(
      {required this.title,
      required this.subTitle,
      required this.link,
      required this.icon});
}

const appMenuItems = <MenuItem>[
  MenuItem(
      title: "Botones",
      subTitle: "Several botones",
      link: "/btns",
      icon: Icons.smart_button),
  MenuItem(
      title: "Tarjetas",
      subTitle: "Several tarjetas",
      link: "/cards",
      icon: Icons.card_giftcard),
  MenuItem(
      title: "Tablas",
      subTitle: "Several tablas",
      link: "/tbls",
      icon: Icons.table_bar),
];
