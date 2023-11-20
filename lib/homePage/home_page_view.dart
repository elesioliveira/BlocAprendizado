import 'package:flutter/material.dart';
import 'package:flutter_application_cubit/homePage/cubit/screen_cubit.dart';
import 'package:flutter_application_cubit/homePage/cubit/screen_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final ScreenCubit cubit; //começo do get.find()
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    cubit = BlocProvider.of<ScreenCubit>(context); //seria o Get.find()
    cubit.stream.listen((event) {
      if (event is ErrorScreenState) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(event.message),
          ),
        );
      }
    });
  }

  @override
  build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.onInverseSurface,
        title: const Text('Lista de Tarefas'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          BlocBuilder(
            bloc: cubit,
            builder: (context, state) {
              if (state is InitialScreenState) {
                return const Center(
                  child: Text('Nenhuma tarefa adicionada'),
                );
              } else if (state is LoadingScreenState) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.black,
                  ),
                );
              } else if (state is LoadedScreenState) {
                return _buildTodoList(state.todos);
              } else {
                return _buildTodoList(cubit.todos);
              }
            },
          ),
          Positioned(
            right: 0,
            bottom: 0,
            left: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(.03),
                      offset: const Offset(0, -5),
                      blurRadius: 4),
                ],
              ),
              padding: const EdgeInsets.all(
                16,
              ),
              child: SafeArea(
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _controller,
                        decoration: InputDecoration(
                            hintText: 'Digite a tarefa..',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                            )),
                      ),
                    ),
                    const SizedBox(width: 16),
                    GestureDetector(
                      onTap: () {
                        cubit.addTodo(value: _controller.text.toUpperCase());
                        _controller.clear();
                        FocusScope.of(context).unfocus();
                      },
                      child: CircleAvatar(
                        backgroundColor: Theme.of(context).primaryColor,
                        child: const Center(
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTodoList(List<String> todos) {
    return ListView.separated(
      itemBuilder: (_, index) {
        return ListTile(
          leading: CircleAvatar(
            child: Center(
              child: Text(
                todos[index][0],
              ),
            ),
          ),
          title: Text(todos[index]),
          trailing: IconButton(
            onPressed: () {
              cubit.removeValue(index: index);
            },
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) => const SizedBox(
        height: 5,
      ),
      itemCount: todos.length,
    );
  }
}
