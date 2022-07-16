$(function(){
    var list = $('.user-select'),
        items = $('.user-select-item'),
        search = $('.user-search-input'),
        placeholder = $('.user-none');

    if(list[0].scrollHeight <= list[0].clientHeight){
        search.closest('.user-search').hide();
    }

    var users = [];
    items.each(function(i){
        let user = {
            name_elm: this.getElementsByClassName('user-name')[0],
            id_elm: this.getElementsByClassName('user-id')[0]
        };
        user.name = user.name_elm.textContent.trim();
        user.searchname = user.name.toLowerCase();
        user.id = user.id_elm.textContent.trim();

        users[i] = user;
    })

    search.on('input', function(){
        list.html('')
        if(!this.value.length){
            list.append(items);
            placeholder.hide();
            return;
        }

        const search = this.value.split(/[\W]+/).filter(function(a){return !!a});

        for(const [i, user] of users.entries()){
            user.match = {name: [], id: []}
            let name_offset = 0, id_offset = 0;

            for(const str of search){
                if(!str.lenght){

                }
                if((name_offset = user.searchname.indexOf(str)) > -1){
                    user.match.name.push([name_offset, str.length]);
                }
                if((id_offset = user.id.indexOf(str)) > -1){
                    user.match.id.push([id_offset, str.length]);
                }
            }
            if(user.match.name.length || user.match.id.length){
                console.log(i, user.match.name, user.match.id)
                items.eq(i).appendTo(list);
                highlight(user.name_elm, user.name, user.match.name);
                highlight(user.id_elm, user.id, user.match.id)
            } else{
                items.eq(i).detach();
            }
        }

        placeholder.toggle(!list.children().length)
    })

    function highlight(elm, text, list) {
        elm.innerHTML = text;
        if(!list.length){
            return;
        }

        list.sort(function(a, b){
            return a[0] - b[0];
        })

        let hhtml = '', last = 0;
        for(const [offset, len] of list){
            if(offset < last){
                continue;
            }
            hhtml += text.substr(last, offset - last)
                + '<span class="highlight">' + text.substr(offset, len) + '</span>';
            last = offset + len
        }
        hhtml += text.substr(last)
        console.log(hhtml)
        elm.innerHTML = hhtml;
    }
})