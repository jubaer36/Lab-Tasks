#include <iostream>

#include "SceneGraph.h"
#include "Util.h"

const char* OUT_IMAGE_PATH_BOX = "./OutImage_Box.png";
const char* OUT_IMAGE_PATH_ARM = "./OutImage_Arm.png";
const char* OUT_IMAGE_PATH_SCG = "./OutImage_SCG.png";

void Task_DrawBox();
void Task_DrawArm();
void Task_DrawSCG();

int main()
{
	Task_DrawBox();
	Task_DrawArm();
	Task_DrawSCG();
	
	return 0;
}

void Task_DrawBox()
{
	Image boxImage{ 500U, 500U, NamedColors::White };

	Quad2D testBox{
		std::vector<Point>{ {20.0, 20.0}, {20.0, -20.0}, {-20.0, -20.0}, {-20.0, 20.0} },
		NamedColors::Blue
	};

	testBox.Draw(boxImage);

	// ToDo: Task 3 - Set the following transformation for testBox
	//		1. Scale it in it own coordinates system 5 and 3 times
	//		   in the X and Y direction respectively
	//		2. Rotate it by 80 degrees counter-clockwise around its
	//		   own axis
	//		3. Translate the box by 200 and 300 in the X and Y
	//		   directions respectively
	//
	// Call testBox.SetTransformation(Transfrom2D) function with the
	// required transformation matrix. As it takes only one argument,
	// basically you will pass a product (multiplication) of three
	// matrices, scale, rotate, and translate to this function. You
	// should use the functions for transformation that you have
	// defined under Transfrom namespace before. Such as, for scaling,
	// Transform::Scale2D(double, double), etc.
	//
	// [N.B.] The order of applying should be reverse (right to left)
	// of the given order. To convert the angle from degree to radian,
	// you can use DegreesToRadians(double) function from Util.h. It
	// is already included for you.

	testBox.SetTransformation(
		// Set your transformation here after removing the identity
		// matrix.

		Transform::Translate2D(200,300)*
		Transform::Rotate2D(DegreesToRadians(80))*
		Transform::Scale2D(5,3)
	);

	testBox.SetColor(NamedColors::BloodRed);

	testBox.Draw(boxImage);

	boxImage.Write(OUT_IMAGE_PATH_BOX);

	std::cout << "Drawn transformed box to <" << OUT_IMAGE_PATH_BOX << '>' << std::endl;
}

void Task_DrawArm()
{
	Image armImage{ 500U, 500U, NamedColors::White };

	Arm2D testArm{ 30.0, 80, NamedColors::Black };

	testArm.Draw(armImage);

	testArm.SetTransformation(
		Transform::Translate2D(250.0, 50.0) *
		Transform::Rotate2D(DegreesToRadians(45.0))
	);

	testArm.Draw(armImage);

	armImage.Write(OUT_IMAGE_PATH_ARM);

	std::cout << "Drawn transformed arm to <" << OUT_IMAGE_PATH_ARM << '>' << std::endl;
}

void Task_DrawSCG()
{
	Image scgImage{ 500U, 500U, NamedColors::White };

	// -----------------------------//
	// --- Object for Instancing ---//
	// -----------------------------//

	std::shared_ptr<Arm2D> armbase = std::make_shared<Arm2D>(30.0, 80, NamedColors::Black);

	// ---------------------//
	// --- Node Creation ---//
	// ---------------------//

	// Node 0: Bottom Node
	std::shared_ptr<SceneNode> node0 = std::make_shared<SceneNode>(armbase);
	node0->SetTransformation(
		Transform::Translate2D(250.0, 50.0) *
		Transform::Rotate2D(DegreesToRadians(-30))
	);

	// Node 1: Middle Node
	std::shared_ptr<SceneNode> node1 = std::make_shared<SceneNode>(armbase);
	node1->SetTransformation(
		Transform::Translate2D(0.0, 80.0) *
		Transform::Rotate2D(DegreesToRadians(45))
	);

	// Node 2: Top Node
	std::shared_ptr<SceneNode> node2 = std::make_shared<SceneNode>(armbase);
	node2->SetTransformation(
		Transform::Translate2D(0.0, 80.0) *
		Transform::Rotate2D(DegreesToRadians(-2))
	);

	// Node FL: Fork Left Node
	std::shared_ptr<SceneNode> nodeFL = std::make_shared<SceneNode>(armbase);
	nodeFL->SetTransformation(
		Transform::Translate2D(0.0, 80.0) *
		Transform::Rotate2D(DegreesToRadians(45))
	);

	// Node FR: Fork Right Node
	std::shared_ptr<SceneNode> nodeFR = std::make_shared<SceneNode>(armbase);
	nodeFR->SetTransformation(
		Transform::Translate2D(0.0, 80.0) *
		Transform::Rotate2D(DegreesToRadians(-45))
	);

	// Node FLT: Fork Left Top Node
	std::shared_ptr<SceneNode> nodeFLT = std::make_shared<SceneNode>(armbase);
	nodeFLT->SetTransformation(
		Transform::Translate2D(0.0, 80.0) *
		Transform::Rotate2D(DegreesToRadians(90))
	);

	// Node FLR: Fork Right Top Node
	std::shared_ptr<SceneNode> nodeFRT = std::make_shared<SceneNode>(armbase);
	nodeFRT->SetTransformation(
		Transform::Translate2D(0.0, 80.0) *
		Transform::Rotate2D(DegreesToRadians(-30))
	);

	// --------------------//
	// --- Node Linking ---//
	// --------------------//

	node0->AddChildren(node1);
	node1->AddChildren(node2);
	node2->AddChildren(nodeFL);
	node2->AddChildren(nodeFR);
	nodeFL->AddChildren(nodeFLT);
	nodeFR->AddChildren(nodeFRT);

	// ----------------------//
	// --- Graph Creation ---//
	// ----------------------//

	SceneGraph scg{ node0 };

	// ---------------//
	// --- Drawing ---//
	// ---------------//

	scg.Draw(scgImage);

	// ---------------//
	// --- Writing ---//
	// ---------------//

	scgImage.Write(OUT_IMAGE_PATH_SCG);

	std::cout << "Drawn scene graph render to <" << OUT_IMAGE_PATH_SCG << '>' << std::endl;
}
