var radioButtonsDeselectable = false

// Allows "deselection" of radio buttons - since the "tabs" are secret radio
// buttons, this allows the collapsing of all categories (for mobile screens)
function enableDeselectableRadioButtons(rootElement) {
  if (!rootElement) {
    rootElement = document
  }
  if (!window.radioChecked) {
    window.radioChecked = {}
  }
  window.radioClick = function (e) {
    const obj = e.target
    const name = obj.name || 'unnamed'
    if (e.keyCode) {
      return (obj.checked = e.keyCode != 32)
    }
    obj.checked = window.radioChecked[name] != obj
    window.radioChecked[name] = obj.checked ? obj : null
  }
  rootElement.querySelectorAll('input[type="radio"]').forEach((radio) => {
    radio.setAttribute('onclick', 'radioClick(event)')
    radio.setAttribute('onkeyup', 'radioClick(event)')
  })
  radioButtonsDeselectable = true
}

// Function to remove the ability to "deselect" radio buttons
function disableDeselectablRadioButtons() {
  document.querySelectorAll('input[type="radio"]').forEach((radio) => {
    radio.removeAttribute('onclick')
    radio.removeAttribute('onkeyup')
  })
  radioButtonsDeselectable = false
}

// Trigger this function on resizes to window; going from narrow to wide it
// will enable "deselecting", going from wide to narrow will disable it
function checkWindowWidth() {
  if (window.innerWidth <= 768 & !radioButtonsDeselectable) {
    console.log('Going narrow')
    enableDeselectableRadioButtons()
    return
  }
  if (window.innerWidth > 768 & radioButtonsDeselectable) {
    console.log('Going wide')
    disableDeselectablRadioButtons()
    return
  }
}

// Trigger once when page loads
checkWindowWidth()

// Attach event listener to window's resize event
window.addEventListener('resize', function () {
  checkWindowWidth()
})
