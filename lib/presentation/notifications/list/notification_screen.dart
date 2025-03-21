import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'components/notification_list.dart';
import 'notification_list_view_model.dart';



class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  late NotificationListViewModel viewModel;

  @override
  void initState() {
    viewModel = Provider.of<NotificationListViewModel>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      viewModel.getNotifications();
      // viewModel.getShops(widget.categoryId);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications"),
        
      ),
    
      body: Consumer<NotificationListViewModel>(
        builder: (context, viewModel, child) {
          return Column(
            children: [
              if (viewModel.loadingOrders) ...[
                const Expanded(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ] else if (viewModel.notifications.isEmpty) ...[
                Expanded(
                  child: Center(
                    child: Text(
                      'No Notifications available ',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ),
              ] else ...[
                Expanded(
                  child: NotificationList(
                    notifications: viewModel.notifications,
                  ),
                )
              ],
            ],
          );
        },
      ),
    );
  }
}
