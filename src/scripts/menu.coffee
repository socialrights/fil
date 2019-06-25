menuTrigger = document.querySelector('.menu__switch')

menuToggle = () =>
  if (menuTrigger)
    menuTrigger.addEventListener 'click', (event) =>
      event.preventDefault()
      menuTrigger.classList.toggle('isOn')

export default menuToggle
