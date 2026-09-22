#include <Siv3D.hpp>

void Main()
{
    const Font font{32};

    while (System::Update())
    {
        Scene::SetBackground(ColorF{0.1, 0.2, 0.3});
        font(U"Hello, Siv3D!").drawAt(Scene::Center(), Palette::White);
    }
}
