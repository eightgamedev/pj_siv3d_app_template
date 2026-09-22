#include <Siv3D.hpp>

void Main()
{
    const Font font{ 32 };

    while (System::Update())
    {
        font(U"Siv3D functional test").drawAt(Scene::Center(), Palette::White);
    }
}