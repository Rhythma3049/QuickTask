import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:quicktask/screens/login_screen.dart';

import '../../../exports.dart';

// ignore: must_be_immutable
class HomeView extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());
  final GetStorage userData = GetStorage();
  Size? size;

  HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    size = Get.size;
    controller.fetchTasks();

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Color.fromARGB(255, 75, 7, 54),
        title: Text(
          AppConstants.homeTitle,
          style: appBarTextStyle.copyWith(fontSize: 25, color: Colors.white),
        ),
        actions: [
          InkWell(
            child: const Padding(
              padding: EdgeInsets.all(10),
              child: Icon(Icons.logout_sharp, color: Colors.white,),
            ),
            onTap: () {
             Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                         showToast(
        text: "You have been logged out",
        state: ToastStates.success,
      );
            },
          ),
        ],
      ),
      body: SizedBox(
        child: taskList(context),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(
            () => TasksView(),
            transition: Transition.rightToLeft,
          );
        },
        backgroundColor: Color.fromARGB(255, 75, 7, 54),
        child: const Icon(Icons.add, color: AppColors.white),
      ),
    );
  }

  Widget taskList(BuildContext context) {
    return FutureBuilder<List<Task>?>(
      future: controller.fetchTasks(),
      builder: (BuildContext context, AsyncSnapshot<List<Task>?> snapshot) {
        Widget? widget;

        if (snapshot.hasData) {
          if (snapshot.data!.isNotEmpty) {
            return ListView.builder(
              padding: const EdgeInsets.all(10),
              itemBuilder: (context, index) => buildItem(
                context,
                snapshot.data![index],
              ),
              itemCount: snapshot.data!.length,
              controller: controller.listScrollController,
            );
          } else {
            return const Center(
              child: Text("Its emply here, no tasks yet"),
            );
          }
        } else if (snapshot.hasError) {
          widget = Container();
        } else {
          widget = const CircularProgress();
        }
        return widget;
      },
    );
  }

  Widget buildItem(BuildContext context, Task setTask) {
     const IconData add_task = IconData(0xe05b, fontFamily: 'MaterialIcons');
    return Container(
  decoration: BoxDecoration(
    border: Border.all(
      color: Colors.grey, // Border color
      width: 1.0, // Border width
    ),
    borderRadius: BorderRadius.circular(10.0), // Border radius
  ),
  padding: EdgeInsets.all(10.0), // Padding around the container
  margin: EdgeInsets.symmetric(vertical: 5.0), // Margin between each task container
  child: SizedBox(
    height: 100, // Adjust height as needed
    child: ListTile(
      leading: const Icon(add_task, color: Color.fromARGB(255, 75, 7, 54)),
      title: Text(
        setTask.title!,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Description: ${setTask.content!}', // Display description with label
            style: const TextStyle(fontSize: 14),
          ),
          Text(
            'Due Date: ${setTask.dueDate!}', // Display due date with label
            style: const TextStyle(fontSize: 12),
          ),
          Text(
            'Status: ${setTask.Status! ? "Complete" : "Incomplete"}', // Display status with label
            style: TextStyle(
              fontSize: 12,
              color: setTask.Status! ? Colors.green : Colors.red, // Set color based on status
            ),
          ),
        ],
      ),
      onTap: () {
        Get.to(
          () => TasksView(currentTask: setTask),
          transition: Transition.rightToLeft,
        );
      },
    ),
  ),
);



  }
}
