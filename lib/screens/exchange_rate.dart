import 'package:app_convention/services/exchange_service.dart';
import 'package:flutter/material.dart';

class ExchangeRateWidget extends StatefulWidget {
  const ExchangeRateWidget({super.key});

  @override
  State<ExchangeRateWidget> createState() => _ExchangeRateWidgetState();
}

class _ExchangeRateWidgetState extends State<ExchangeRateWidget> {
  bool loading = true;
  double? tipoCambio;

  @override
  void initState() {
    super.initState();
    cargarTipoCambio();
  }

  Future<void> cargarTipoCambio() async {
    final service = ExchangeRateService();
    final valor = await service.obtenerTipoCambioUsdAPen();
    setState(() {
      tipoCambio = valor;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (loading) return const CircularProgressIndicator();

    return Card(
      margin: const EdgeInsets.all(16),
      child: ListTile(
        leading: const Icon(Icons.attach_money),
        title: const Text("Tasa de cambio USD a PEN"),
        subtitle: Text("1 USD ≈ ${tipoCambio?.toStringAsFixed(2) ?? '--'} PEN"),
      ),
    );
  }
}
