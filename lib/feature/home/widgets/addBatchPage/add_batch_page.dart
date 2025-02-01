import 'package:basic_app/common/widgets/show_card.dart';
import 'package:flutter/material.dart';

class AddBatchPage extends StatelessWidget {
  final double screenHeight;
  final double screenWidth;

  const AddBatchPage({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Adicione seus produtos:',
          style: TextStyle(
            fontSize: screenWidth * .023,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
      body: ShowCard(screenHeight: screenHeight, screenWidth: screenWidth),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(
          vertical: screenHeight * 0.01,
          horizontal: screenHeight * 0.05,
        ),
        child: Row(
          children: [
            Flexible(
              flex: 1,
              child: SizedBox(
                height: screenHeight * 0.07,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: SizedBox(
                    width: screenWidth * 0.2,
                    height: screenHeight * 0.1,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddBatchPage(
                              screenHeight: screenHeight,
                              screenWidth: screenWidth,
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Theme.of(context).colorScheme.inversePrimary,
                        padding: EdgeInsets.symmetric(
                          vertical: screenHeight * 0.01,
                          horizontal: screenWidth * 0.01,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Finalizar venda',
                        style: TextStyle(
                          fontSize: screenWidth * 0.02,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Spacer(),
            Text(
              'Total: 10,50',
              textAlign: TextAlign.end,
              style: TextStyle(
                fontSize: screenWidth * 0.02,
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
