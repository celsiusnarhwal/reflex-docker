"""Welcome to Reflex! This file outlines the steps to create a basic app."""

import reflex as rx

from rxconfig import config
import RIL as icons


class State(rx.State):
    """The app state."""

    ...


def index() -> rx.Component:
    # Welcome Page (Index)
    return rx.container(
        rx.color_mode.button(position="top-right"),
        rx.vstack(
            rx.heading("Welcome to Reflex!", size="9"),
            rx.text(
                "Get started by editing ",
                rx.code(f"{config.app_name}/{config.app_name}.py"),
                size="5",
            ),
            rx.link(
                rx.button("Check out our docs!"),
                href="https://reflex.dev/docs/getting-started/introduction/",
                is_external=True,
            ),
            icons.fa("house"),
            icons.fa.brands("python"),
            spacing="5",
            justify="center",
            min_height="85vh",
        ),
        rx.logo(),
    )


@rx.page("/[number]")
def num():
    return rx.heading(rx.State.number)


app = rx.App()
app.add_page(index)
