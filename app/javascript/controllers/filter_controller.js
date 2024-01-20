import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  static targets = [ 'minViews', 'maxViews' ]

  connect() {
    console.log('Hello World heh')
  }

  open(){
    console.log('filter triggered')
    document.getElementsByClassName('modal')[0].classList.add('is-active')
  }

  close(){
    console.log('close triggered')
    document.getElementsByClassName('modal')[0].classList.remove('is-active')
  }

  sieve_table(min, max, columnidentifier){
    var list = document.getElementsByClassName(columnidentifier)
    for (let item of list) {
      console.log(this.minViewsTarget.value, typeof(item.innerHTML), typeof(this.maxViewsTarget.value))
      console.log((item.innerHTML < min ) || (item.innerHTML > this.maxViewsTarget.value))
      if((parseFloat(item.innerHTML) < min) || (parseFloat(item.innerHTML) > max)){
        item.parentElement.style.display = 'none'
      }
      else{
        item.parentElement.style.display = 'contents'
      }
    }
  }

  apply(){
    this.sieve_table(parseFloat(this.minViewsTarget.value), parseFloat(this.maxViewsTarget.value), 'viewCount')
    this.close()
  }

  reset(){
    this.sieve_table(parseFloat(''), parseFloat(''), 'viewCount')
    this.close()
  }
}
