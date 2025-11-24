#include "Shapes.h"

#include "Curves.h"

void Quad2D::Draw(Image& image) const
{
	// ToDo: Task 2 - You will implenting the drawing logic of this quad.
	// A quad is a shape with 4 sides. Basically, you will create
	// homogeneous vertices (add a last coordinate of 1) from the
	// given vertices. Then for each vertex, you will apply all the
	// transformation for the shape retrievable using GetTransformation()
	// function. You should take a look at the inheritance chain of Quad2D
	// in Shapes.h to better understand its properties.
	//
	// Once the transformation is applied, you now have a new set of vertices.
	// If they are noted using p0, p1, p2, and p3, then draw lines between
	// (p0, p1), (p1, p2), (p2, p3), and (p3, p0) to create a quad. Then
	// just draw two more lines between (p0, p2) and (p1, p3) to draw the
	// diagonals as well to make it easier to visualize. Draw lines using
	// the DrawLine(...) function from Curves.h.
      blaze::StaticMatrix<double, 3, 5> geoMat{
        {m_Vertices[0].X, m_Vertices[1].X, m_Vertices[2].X, m_Vertices[3].X,0.0},
        {m_Vertices[0].Y, m_Vertices[1].Y, m_Vertices[2].Y, m_Vertices[3].Y,0.0},
        {1.0, 1.0, 1.0, 1.0,1.0}
    };

 
    geoMat = GetTransformation() * geoMat;
  
    const Point p0{ geoMat(0, 0), geoMat(1, 0) };
    const Point p1{ geoMat(0, 1), geoMat(1, 1) };
    const Point p2{ geoMat(0, 2), geoMat(1, 2) };
    const Point p3{ geoMat(0, 3), geoMat(1, 3) };

    DrawLine(image, p0, p1, GetColor());
    DrawLine(image, p1, p2, GetColor());
    DrawLine(image, p2, p3, GetColor());
    DrawLine(image, p3, p0, GetColor());

  
    DrawLine(image, p0, p2, GetColor());
    DrawLine(image, p1, p3, GetColor());	
	return;
}

Arm2D::Arm2D(double baseWidth, double height, Color color)
	: ColoredShape2D(color)
{
	m_Vertices.emplace_back(-(baseWidth / 2.0),    0.0);
	m_Vertices.emplace_back( (baseWidth / 2.0),	   0.0);
	m_Vertices.emplace_back(			   0.0, height);
}

void Arm2D::Draw(Image& image) const
{
	blaze::StaticMatrix<double, 3, 4> geoMat{
		{m_Vertices[0].X, m_Vertices[1].X, m_Vertices[2].X, 0.0},
		{m_Vertices[0].Y, m_Vertices[1].Y, m_Vertices[2].Y, 0.0},
		{			 1.0, 			  1.0, 			   1.0, 1.0}
	};

	geoMat = GetTransformation() * geoMat;

	const Point p0{ geoMat(0, 0), geoMat(1, 0) };
	const Point p1{ geoMat(0, 1), geoMat(1, 1) };
	const Point p2{ geoMat(0, 2), geoMat(1, 2) };
	const Point  c{ geoMat(0, 3), geoMat(1, 3) };
	double radius = blaze::norm(static_cast<Point2>(p0) - static_cast<Point2>(c));

	DrawLine(image, p0, p1, GetColor());				// Arm 1
	DrawLine(image, p1, p2, GetColor());		// Arm 2
	DrawLine(image, p2, p0, GetColor());		// Arm 3
	DrawCircle(image, c, radius, GetColor());	// Filled circle
}
