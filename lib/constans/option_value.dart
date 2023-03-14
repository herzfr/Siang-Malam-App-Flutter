// PO Status Value List

import 'package:flutter/material.dart';

const statusPo = [
  DropdownMenuItem<String>(child: Text('Batal'), value: 'CANCEL'),
  DropdownMenuItem<String>(child: Text('Tertunda'), value: 'PENDING'),
  DropdownMenuItem<String>(child: Text('Lunas'), value: 'PAID'),
  DropdownMenuItem<String>(child: Text('Belum Bayar'), value: 'UNPAID'),
  DropdownMenuItem<String>(child: Text('Semua'), value: 'ALL'),
];

const optionPo = [
  DropdownMenuItem<String>(child: Text('No Orderan'), value: 'orderno'),
  DropdownMenuItem<String>(child: Text('Catatan'), value: 'note'),
];
const orderPo = [
  DropdownMenuItem<String>(child: Text('Dibuat'), value: 'createdAt'),
  DropdownMenuItem<String>(child: Text('Diubah'), value: 'updatedAt'),
];

const sortPo = [
  DropdownMenuItem<String>(child: Text('Yang Terakhir'), value: 'asc'),
  DropdownMenuItem<String>(child: Text('Yang Terbaru'), value: 'desc'),
];

const typeDisc = [
  DropdownMenuItem<String>(
      child: Text('Dalam Bentuk Persen'), value: 'PERCENT'),
  DropdownMenuItem<String>(child: Text('Dalam Bentuk Rupiah'), value: 'RUPIAH'),
];

const typeOrder = [
  DropdownMenuItem<int>(child: Text('Bawa Pulang/Bungkus'), value: 1),
  DropdownMenuItem<int>(child: Text('Makan di Tempat'), value: 2),
];

const typeFindOrder = [
  DropdownMenuItem<String>(child: Text('Berdasarkan ID'), value: "salesId"),
  DropdownMenuItem<String>(child: Text('Berdasarkan Nama'), value: "name"),
];

const typeFindStartDate = [
  DropdownMenuItem<int>(child: Text('Per 1 Hari'), value: 1),
  DropdownMenuItem<int>(child: Text('Per 2 Hari'), value: 2),
  DropdownMenuItem<int>(child: Text('Per 3 Hari'), value: 3),
  DropdownMenuItem<int>(child: Text('Per 7 Hari'), value: 7),
  DropdownMenuItem<int>(child: Text('Per 2 Minggu'), value: 14),
  DropdownMenuItem<int>(child: Text('Per 3 Minggu'), value: 21),
  DropdownMenuItem<int>(child: Text('Per 1 Bulan'), value: 30),
];

const typeFindStatusSales = [
  DropdownMenuItem<String>(child: Text('Semua'), value: "ALL"),
  DropdownMenuItem<String>(child: Text('Tunai'), value: "PAID"),
  DropdownMenuItem<String>(child: Text('Debit'), value: "DEBT"),
];

const typeFindOptionSales = [
  DropdownMenuItem<String>(child: Text('Nama'), value: "name"),
  DropdownMenuItem<String>(child: Text('Pelanggan'), value: "customer"),
  DropdownMenuItem<String>(child: Text('Kasir'), value: "cashier"),
];

const typeOptionShift = [
  DropdownMenuItem<String>(child: Text('Semua'), value: "ALL"),
  DropdownMenuItem<String>(child: Text('Close'), value: "CLOSE"),
  DropdownMenuItem<String>(child: Text('Open'), value: "OPEN"),
];

const typeTransfer = [
  DropdownMenuItem<String>(child: Text('Dikirim'), value: 'send'),
  DropdownMenuItem<String>(child: Text('Diterima'), value: 'receive'),
];
