function conf_mat = get_confusion_matrix(class1, class2, misclass1, misclass2)

    conf_mat = [0 0; 0 0];

    num_misclass1 = size(misclass1, 1);
    num_misclass2 = size(misclass2, 1);


    conf_mat(1,1) = length(class1) - size(misclass1, 1);
    conf_mat(2,2) = length(class2) - size(misclass2, 1);

    conf_mat(1,2) = size(misclass1, 1);
    conf_mat(2,1) = size(misclass2, 1);
end