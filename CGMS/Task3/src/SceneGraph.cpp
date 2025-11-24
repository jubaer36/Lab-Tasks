#include "SceneGraph.h"

void SceneNode::AddChildren(std::shared_ptr<SceneNode> child)
{
	// The following shared pointer with special deletion is required to
	// avoid circular dependency of shared pointers
	//
	// [N.B.] This would have been a task, but due to the weird looking use
	// of shared_ptr constructor, I have completed it for you.
	child->m_Parent = std::shared_ptr<SceneNode>(this, [](SceneNode*){ });
	m_Children.push_back(child);
}

void SceneNode::UpdateModelMatrix()
{
	// ToDo: Task 4 - Update logic for the model matrix of a SceneNode.
	// Here, you will be setting the value of the model matrix of the
	// current scene node.
	// 
	// First check whether the parent, m_Parent is a nullptr or not. If
	// it is a nullptr, it means this node is isolated and should be
	// considered as the root of the scene. In that case, Its model matrix
	// is its own transformation only.
	//
	// If the parent is not null, in that case, first fetch the model matrix
	// of its parent and then multiply that with its own transformation. You
	// will then get the model matrix for the current node.
	//
	// [N.B.] Yes, this task is just an if-else statement.
	if(m_Parent!=nullptr)
	{
		m_ModelMatrix=m_Parent->m_ModelMatrix*m_Transformation;
	}
	else m_ModelMatrix=m_Transformation;
}

void SceneNode::Draw(Image& image, bool update)
{
	// ToDo: Task 5 - Drawing logic for a scene node. The update
	// variable, the default value of which is set to 'true' in
	// SceneGraph.h indicates where the model matrix be recalculated.
	// Once all the model matrices been updated, the value of update
	// can be set to 'false' while calling the function for static
	// scenes, but we will not check that for now.
	//
	// First, if update is true, update the model matrix of current
	// node by calling the appropriate method.
	//
	// Then, if the shape pointer is not a nullptr (it has a physical
	// shape inside it), set the transformation of the shape under 
	// current scene node to the model matrix. After that, call the 
	// draw method of the shape. Remember, it is a pointer, so you
	// need to use the arrow (->) operator for member access.
	//
	// Finally, iterate through all the children of current scene node
	// and call their respective Draw(Image) method. It is implicitly
	// performing Depth First Exploration.
	if(update==true)
	{
		UpdateModelMatrix();
	}
	if(m_Shape!=nullptr)
	{
			m_Shape->SetTransformation(m_ModelMatrix);
			m_Shape->Draw(image);
	}
	for(auto child:m_Children)
	{
		child->Draw(image,update);
	}

}
